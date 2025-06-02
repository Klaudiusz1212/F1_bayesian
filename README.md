# F1 Bayesian

This project uses Stan for Bayesian modeling. To run Stan models in this repository, you can use Docker for a consistent and isolated environment.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your machine.

### Running Stan with Docker

1. Open a terminal and navigate to the project directory:

   ```bash
   cd /path/to/F1_bayesian
   ```

2. Start the Stan Docker container:

   ```bash
   docker run -p 8888:8888 \
     --mount type=bind,source=./stan,target=/workspace \
     -d --name stan_F1 iszagh/cmdstan_python
   ```

   - This command maps the local `./stan` directory to `/workspace` in the container.
   - The container runs in detached mode (`-d`) and exposes port 8888.

## Project Structure

- `stan/` - Contains Stan models and related scripts.

## Notes

- Make sure any changes in the `stan/` directory are saved before stopping the container.
- For more information on CmdStanPy, see the [CmdStanPy documentation](https://cmdstanpy.readthedocs.io/).
