# Chembl-beaker Docker
RDKit and OSRA in the Bottle on Tornado as a Docker Image

Dockerized version of the Chembl [chembl-beaker](https://github.com/chembl/chembl_beaker) webserver that exposes functions for transformation of molecular information into other formats as a REST service

## What is Beaker?

This Docker container builds the chembl_beaker package developed at [ChEMBL](https://www.ebi.ac.uk/chembl/) group, [EMBL-EBI](https://www.ebi.ac.uk/), Cambridge, UK.

Beaker is a wrapper for [RDKit](http://www.rdkit.org/) and [OSRA](http://cactus.nci.nih.gov/osra/), which exposes following methods:

 * [Format conversion](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/conversions/views.py)
 * [Compound recognition](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/osra/views.py)
 * [Raster image (PNG) generation](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/rasterImages/views.py)
 * [Vector image (SVG) generation](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/svgImages/views.py)
 * [HTML5 ready compound representation](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/jsonImages/views.py)
 * [Fingerprints](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/fingerprints/views.py)
 * [Descriptors](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/descriptors/views.py)
 * [Ring information](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/ringInfo/views.py)
 * [Maximum Common Substructure](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/mcs/views.py)
 * [Smiliarity maps](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/similarityMaps/views.py)
 * [ChEMBL standardisation process](https://wwwdev.ebi.ac.uk/chembl/extra/francis/standardiser/), consisting of neutralisation, bond breaking, salt removal and applying various rules.
 * [3D coordinates generation, using Universal Force Field](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/D3Coords/views.py)
 * [Various other calculations (for example kekulisation)](https://github.com/chembl/chembl_beaker/blob/master/chembl_beaker/beaker/core_apps/calculations/views.py)
 * Marvin 4 JS compilant [webservices](https://marvin4js.chemaxon.com/marvin4js-latest/docs/dev/webservices.html)

As a portable, lightweight, [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)-ready, [REST](https://en.wikipedia.org/wiki/Representational_state_transfer)-speaking, [SPORE](https://github.com/SPORE/specifications)-documented webserver. This particular Dockerfile allows you to deploy Beaker without compiling and installing sources or using the Chembl virtual machine image. It wraps RDKit in [Bottle](http://bottlepy.org/docs/dev/) on [Tornado](http://www.tornadoweb.org/en/stable/).

## Installation
Make sure your machine supports Docker, then (assuming Linux) type `docker pull jjander/chembl_beaker` to pull the Dockerfile from Docker-Hub and build it on your machine. Or `git clone https://github.com/iSnow/chembl_beaker-docker.git && docker build  -t chembl/beaker:1.1.14 .` to pull the latest version from Github and build it on your machine.

## Running Beaker
(assuming Linux) type `docker run -p 7655:8080 chembl/beaker:1.1.14` to start the image. Point your browser to http://<DOCKER-SERVER>:8080/docs (e.g. http://localhost:8080/docs) to start using Beaker.

## Additional information

* [OCR for images of chemical structures](https://metamolecular.com/blog/2013/08/07/reading-chemical-structures-from-images-with-osra-2-0/) - installation instruction for OSRA 2.0 which is used in this Beaker distribution
* [myChembl 29 released](http://chembl.blogspot.de/2014/10/mychembl-19-released.html) - myChembl also contains Beaker if you'd rather use it via a VM and integrated with iPython notebooks. See also [this description](https://academic.oup.com/nar/article/43/W1/W612/2467881/ChEMBL-web-services-streamlining-access-to-drug) of the ChEMBL webservices update and the [API description](https://www.ebi.ac.uk/chembl/ws)
* [installing RDKit with Anaconda](http://www.rdkit.org/docs/Install.html) - Miniconda, a related version is used to install RDKit in this Beaker distribution. Compiling RDKit for Docker is described in [this Dockerfile](https://hub.docker.com/r/informaticsmatters/rdkit/~/dockerfile/)

