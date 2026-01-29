# sanskrit-heritage

The Sanskrit Heritage Platform by Gérard Huet and Pawan Goyal provides tools for Sanskrit language analysis - available at https://sanskrit.inria.fr/ from INRIA.

This project provides a devenv shell with nixpkgs to build and run the platform using OCaml 4.07 with Camlp4.

## Directory Structure

Clone all 4 repositories into this layout:

```
sanskrit-heritage/
├── Zen/                    # OCaml computational linguistics toolkit
├── Heritage_Resources/     # Morphological data, dictionaries, transducers
├── Heritage_Platform/      # Web interface and CGI services
├── webroot/                # Apache document root
└── conf/                   # Apache configuration
```

## Setup Steps

1. Enter the devenv shell (provides OCaml 4.07, camlp4, apache):
   ```bash
   cd sanskrit-heritage
   devenv shell
   ```

you also need to isntall the zen/ml tools before you can do the next step

2. Configure Heritage_Platform with paths to Zen and Resources:
   ```bash
   cd Heritage_Platform
   ./configure
   ```

3. Build and install:
   ```bash
   make && make install
   ```

4. Run the HTTP server:
   ```bash
   cp-httpd-conf
   heritage-cgi  # Runs Apache httpd on port 4040
   ```

Access the platform at http://localhost:4040

## Configuration Details

The configure script reads `SETUP/config` which should point to:

- `ZENDIR`: Path to Zen/ML (e.g., `../Zen/ML`)
- `SKTRESOURCES`: Path to Heritage_Resources (e.g., `../Heritage_Resources`)
- `SERVERPUBLICDIR`: Where web files are served from
- `CGIDIR`: Where CGI executables are installed

Want to check that everything works?

```bash
   curl -I http://localhost:4040/cgi-bin/sktreader
   curl -I http://localhost:4040/skt/DICO/style.css

```

## Project Links

- [Sanskrit Heritage INRIA](https://sanskrit.inria.fr/)
- [Zen GitLab](https://gitlab.inria.fr/huet/Zen.git)

