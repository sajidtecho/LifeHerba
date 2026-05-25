# Deployment & DevOps

This directory contains deployment strategies, continuous integration / deployment (CI/CD) pipelines, and Docker configs.

## Environments
1. **Development**: Local environment utilizing docker-compose.
2. **Staging**: Deployed automatically upon merge to `develop` branch.
3. **Production**: Multi-zone orchestration deployed on merge to `main` branch.

## CI/CD Workflow
We use Git Actions for running tests and handling builds:
- **Linting & Code Formatting**: Enforced via pre-commit hooks and CI runs.
- **Automated Tests**: All unit/widget tests must pass before pull requests are approved.
