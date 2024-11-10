# Use Python 3.12 as the base image
FROM python:3.12

ARG PARAMETER=${PARAMETER:-""}

ENV PARAMETER=${PARAMETER}

# Create a directory for the application
RUN mkdir /app
# Copy the Python application files into the container
COPY ./src /app/src
COPY ./pyproject.toml /app

WORKDIR /app

# Set PYTHONPATH to include the current working directory
ENV PYTHONPATH=${PYTHONPATH}:${PWD}

# Install Poetry for managing dependencies
RUN pip3 install poetry
# Configure Poetry to not create a virtual environment and install dependencies
RUN poetry config virtualenvs.create false && poetry install

# Set the entrypoint command to run the application with Poetry
ENTRYPOINT [ "poetry", "run", "your-script-name" ]