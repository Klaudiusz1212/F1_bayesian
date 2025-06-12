# F1 Bayesian

A project for Bayesian modeling of Formula 1 data using Stan and CmdStanPy.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your machine.

### Running Stan with Docker

1. Open a terminal and navigate to the project directory:

   ```bash
   cd .../F1_bayesian
   ```

2. Start the Stan Docker container:

   ```bash
   docker run -p 8888:8888 \
     --mount type=bind,source=./,target=/workspace \
     -d --name stan_F1 iszagh/cmdstan_python
   ```

   - This command maps your local project directory to `/workspace` in the container.
   - The container runs in detached mode (`-d`) and exposes port 8888.

## Project Structure

- `stan/` - Contains Stan models and related scripts.
- `data/` - Contains datasets used for modeling.
- `images/` - Contains images and visualizations.

## Notes

- For more information on CmdStanPy, see the [CmdStanPy documentation](https://cmdstanpy.readthedocs.io/).
