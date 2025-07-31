# GandoPages

Just a dumb Docker container for your static assets (I use this for my [exported laravel sites](https://github.com/spatie/laravel-export)).

_I ain't gonna need a VPS for that shi..._

_... but still, I test._

## Use cases

- You have a bunch of newly generated static assets you'd like to test out, without configuring a webserver on your machine.
- You have exported a website from a module-oriented SSR framework and you want to use Cloudflare Pages or equivalent.
- You don't wanna learn proper frontend tools. I'm not pointing fingers to anybody (but myself).
- You also really don't want to meddle with certs, nor HTTPS redirect: these work out of the box.

## Requirements

- Docker compose

## Installation

1. Clone the repository

2. Build the Docker image:
   ```bash
   docker-compose build
   ```
3. Copy your website static files to the `./dist` directory in the cloned repository (you'll need to create it).

4. Edit the `.env` file to set the `VIRTUAL_HOST` variable to your domain name.

   Example:

   ```env
   VIRTUAL_HOST=example.com
   ```

5. IMPORTANT: edit your `hosts` file.

6. Start the container:
   ```bash
   docker-compose up -d
   ```

## License

This project is licensed under the [Unlicense](https://unlicense.org/), which allows you to do anything you want with it. I literally couldn't care less.
