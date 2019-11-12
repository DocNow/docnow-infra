# docnow-infra
Docnow Terraform Infrastructure

This repo contains the main Terraform config for DocNow. Make sure to read through the [ADRs](docs/adrs) first.

## Workspaces

We maintain both `prod` and `stage` workspaces of most resources. We also have a `global` workspace for resources which are independent of any specific environment. If you have not configured a specific workspace Terraform will use the `default` workspace. Your workspace can be configured by setting the `TF_WORKSPACE` environment variable, or explicitly switching workspaces with the `terraform workspace select` command.

[ADR-2](docs/adrs/0002-use-terraform-workspaces-for-environments.md) provides the rationale for using workspaces.

### Directory Structure

    apps/
    |- docnow/
    |- diffengine/
    global/
    |- global1/
    |- resource.tf
    shared/
    |- shared1/
    |- shared2

### The global Directory

A few resources, e.g. Route53, will only use the `global` workspace. These global resources should go here.

### The shared Directory

This directory is for resources that may be shared between apps. These might include things like Elasticsearch, Redis, etc. These resources generally have `prod` and `stage` counterparts.
