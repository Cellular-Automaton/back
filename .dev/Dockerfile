# Use an official Elixir runtime as a parent image
FROM elixir:1.18.4

# Set the working directory in the container to /app
WORKDIR /app

# Copy the dependency files first to leverage Docker cache
COPY mix.exs mix.lock ./

# Install Hex and Rebar
RUN mix local.hex --force && \
  mix local.rebar --force


# Install mix dependencies
RUN mix deps.get

# Copy the entire project into the container
COPY . .

# Compile the project
RUN mix compile

# Expose the port the app runs on
EXPOSE 4000

# Command to run the application using mix
CMD mix ecto.create && mix ecto.migrate && mix phx.server
