resource "google_sql_user" "keycloak_user" {
  name     = "keycloak"
  instance = var.db_instance_name
  password = var.keycloak_password
}

resource "google_sql_database" "keycloak_database" {
  name     = "keycloakdb"
  instance = var.db_instance_name
}

resource "helm_release" "keycloak" {
  name       = "keycloak"
  chart      = "keycloak"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = "default"

  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  set {
    name  = "keycloak.database.url"
    value = "jdbc:postgresql://${var.db_connection_name}:5432/${google_sql_database.keycloak_database.name}"
  }

  set {
    name  = "keycloak.database.user"
    value = google_sql_user.keycloak_user.name
  }

  set {
    name  = "keycloak.database.password"
    value = google_sql_user.keycloak_user.password
  }

  set {
    name  = "replicaCount"
    value = "1" # Reduce replica count for cost
  }
}
