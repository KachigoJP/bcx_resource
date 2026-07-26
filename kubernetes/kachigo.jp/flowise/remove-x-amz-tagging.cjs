'use strict'

const Module = require('module')

const originalLoad = Module._load

function patchS3Client(s3Module) {
  const S3Client = s3Module && s3Module.S3Client

  if (!S3Client || S3Client.prototype.__removeTaggingPatched) return

  const originalSend = S3Client.prototype.send

  S3Client.prototype.send = function (...args) {
    if (!this.__removeTaggingMiddlewareInstalled) {
      this.middlewareStack.add(
        (next) => async (middlewareArgs) => {
          const request = middlewareArgs.request

          if (request && request.headers) {
            for (const header of Object.keys(request.headers)) {
              if (header.toLowerCase() === 'x-amz-tagging') {
                delete request.headers[header]
              }
            }
          }

          return next(middlewareArgs)
        },
        {
          step: 'build',
          name: 'removeXAmzTaggingHeader',
          priority: 'low'
        }
      )

      Object.defineProperty(this, '__removeTaggingMiddlewareInstalled', {
        value: true
      })
    }

    return originalSend.apply(this, args)
  }

  Object.defineProperty(S3Client.prototype, '__removeTaggingPatched', {
    value: true
  })
}

Module._load = function (request, parent, isMain) {
  const loaded = originalLoad.apply(this, arguments)

  if (
    request === '@aws-sdk/client-s3' ||
    request.endsWith('/@aws-sdk/client-s3')
  ) {
    patchS3Client(loaded)
  }

  return loaded
}

console.log('[aws-sdk-patch] x-amz-tagging removal patch loaded')
