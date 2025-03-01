# sanskrit-heritage

The tool by Gérard Huet and Pawan Goyal available at https://sanskrit.inria.fr/ from the [French Institute for Research in Computer Science and Automation](https://www.inria.fr/en) provides a rich collection of tools for analysis of the sanskrit language.

However: it requires an outdated version of ocaml (4.0.7 circa 2018) and many now deprecated features to function.

Because of the challenges involved with running the service this project provides a 'devenv shell' leveraging nixpkgs for reproducing the build environment.

## installation and running apache server

The heritage project architecture depends on httpd running ocaml cgi-scripts over local xml datasets.

httpd installations are requiring non-root users so we will first require a 'heritage' linux* user to run the platform.

> * tested on x86 linux but may work in other environments as well

prerequisites:
- server with [nix](https://lix.systems/install/) and [devenv](https://devenv.sh/getting-started/) installed
- a non root user that can successfully run `devenv shell`. see: [scripts/add-heritage-user.sh](scripts/add-heritage-user.sh)

once you have the user we can begin, with a copy of this repository checked out to somewhere like `/var/lib/sanskrit-heritage`

```bash
# assuming you have bash on your system installed:
sudo -u heritage -H bash --login 
cd /var/lib/sanskrit-hertiage && devenv shell

# ...
# continue with setup process
```

## submodules

Repositories making up the heritage platform:

- Zen
- Heritage_Resources
- Heritage_Platform

Steps:

- check all 3 repos out
- create heritage platform config and symlink
- ./configure && make && make install
- run httpd over cgi/htdocs data

After completing above steps you should have a running heritage platform available at http://localhost:4040

Next steps can include using tools like [caddy](https://caddyserver.com/docs/getting-started) for layering security and authorization.

