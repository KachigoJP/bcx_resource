# KrakenD Project

This project sets up a KrakenD API Gateway with a basic configuration suitable for deployment in a Kubernetes environment.

## Project Structure

```
krakend
├── config
│   └── krakend.json
├── kubernetes
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
└── README.md
```

## Setup Instructions

1. **Clone the Repository**
   Clone this repository to your local machine.

2. **Configuration**
   - Modify the `config/krakend.json` file to define your API endpoints and backend services.
   - Update the `kubernetes/deployment.yaml` file to set the desired number of replicas and the container image.

3. **Deploying to Kubernetes**
   - Apply the Kubernetes configurations using the following commands:
     ```bash
     kubectl apply -f kubernetes/configmap.yaml
     kubectl apply -f kubernetes/deployment.yaml
     kubectl apply -f kubernetes/service.yaml
     ```

4. **Accessing the Service**
   - Once deployed, you can access the KrakenD service using the service type defined in `kubernetes/service.yaml`.

## Usage

After deployment, you can start using the KrakenD API Gateway to route requests to your backend services as defined in the configuration.

## Additional Information

For more details on KrakenD configuration options and features, refer to the [official KrakenD documentation](https://docs.krakend.io/).