# Argo CD Setup for HTML5 Arcade Game

This directory contains configuration files for setting up Argo CD for continuous deployment of the HTML5 Arcade Game.

## Installation

To install Argo CD in your Kubernetes cluster:

```bash
# Make the script executable
chmod +x install.sh

# Run the installation script
./install.sh
```

### Setting up Secrets

Before deploying applications, set up the required secrets:

```bash
# Make the script executable
chmod +x setup-secrets.sh

# Set Docker Hub credentials and run the script
DOCKERHUB_USERNAME=your-username DOCKERHUB_PASSWORD=your-password ./setup-secrets.sh
```

This will create:
- Docker registry secrets in each environment namespace
- Environment variables for Argo CD to use during sync

This will:
1. Create the argocd namespace
2. Install Argo CD components
3. Expose the Argo CD server
4. Display the initial admin password

## Application Deployment

### Using Individual Applications

To deploy applications to specific environments:

```bash
# Make the script executable
chmod +x deploy.sh

# Deploy to development environment
./deploy.sh --environment dev

# Deploy to test environment
./deploy.sh --environment test

# Deploy to production environment
./deploy.sh --environment prod

# Deploy and sync immediately
./deploy.sh --environment dev --sync
```

### Using ApplicationSet

To deploy all environments at once using ApplicationSet:

```bash
# Deploy all environments
./deploy.sh --environment all
```

## Environment Configuration

Each environment is configured with different settings:

| Environment | Git Branch | Image Tag | Auto Sync | Self Heal |
|-------------|-----------|-----------|-----------|-----------|
| Dev         | develop   | latest    | Yes       | Yes       |
| Test        | staging   | stable    | Yes       | Yes       |
| Prod        | main      | release   | No        | No        |

## Manual Sync

For production, manual sync is required for safety:

```bash
# Sync production application
argocd app sync arcade-game-prod
```

## Image Management

### Updating Image Tags

To update the image tag for a specific environment:

```bash
# Update image tag
./update-image.sh --environment prod --tag main-abc123-20230515123456
```

### Promoting Images Between Environments

To promote an image from one environment to another:

```bash
# Promote from test to prod
./promote-image.sh --source test --target prod
```

## Accessing the Argo CD UI

After installation, you can access the Argo CD UI at the URL provided by the installation script.

Default credentials:
- Username: admin
- Password: (displayed during installation)

Remember to change the default password after first login!