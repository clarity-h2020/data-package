## Rationale
Information consumed by CLARITY Climate Services must be provided in a common Data Package format which contains all or part of the datasets necessary for carrying out the project climate proofing assessment (according to the steps defined in CLARITY EU-GL Methodology (WEB REFERENCE NEEDED HERE)).

Technically, a standardised Data Package can be realised as “distributed data object“, so that not all data must reside in the same location (database, server). Here arises also the need for “Smart Links” that can combine, relate and describe different information entities (in this particular case the distinct elements of Data Package). Furthermore, a serialisation feature for Data Packages is needed that allows to put all contents of package into a concrete (zip) file that can be shared, e.g. with other experts.

Besides, the output of Climate Services must be delivered as such a Standardised Data Package to ensure technical interoperability to the CSIS and thus the Climate Services Ecosystem. Consequently, a Data Package can either reside on the CSIS as Virtual Data Package (distributed among several physical data stores) if the provider of the Expert Climate Service uses the CLARITY CSIS to provide its service, or as concrete file (Serialized Data Package) if the provider works offline.

## Design principles
CLARITY Data Package specification builds on top of the existing Data Package specification provided by Frictionless Data (https://frictionlessdata.io) in accordance with their **design philosphy** (https://frictionlessdata.io/specs):
* _Simplicity_: seek zen-like simplicity in which there is nothing to add and nothing to take away.
* _Extensibility_: design for extensibility and customisation. This makes hard things possible and allows for future evolution
* _Human-editable and machine-usable_: specifications should preserve human readability and editability whilst making machine-use easy.
* _Reuse_: reuse and build on existing standards and formats wherever possible.
* _Cross technology_: support a broad range of languages, technologies and infrastructures -- avoid being tied to any one specific system.

This philosophy is itself based on the overall design principles of the Frictionless Data project:
* _Focused_: sharp focus on one part of the data chain, one specific feature – packaging – and a few specific types of data (e.g. tabular).
* _Web Oriented_: build for the web using formats that are web "native" such as JSON, work naturally with HTTP such as plain text CSVs (which stream).
* _Distributed_: design for a distributed ecosystem with no centralized, single point of failure or dependence.
* _Open_: Anyone should be able to freely and openly use and reuse what we build.
* _Existing Software_: Integrate as easily as possible with existing software both by building integrations and designing for direct use – for example we like CSV because everyone has a tool that can access CSV.
* _Simple, Lightweight_: Add the minimum, do the least required, keep it simple. For example, use the most basic formats, require only the most essential metadata, data should have nothing extraneous.


## Structure overview
A CLARITY Data Package consists of (in a similar manner to a common Data Package, https://frictionlessdata.io/specs/data-package/):

* **Metadata** that describes the structure and contents of the package
* **Resources** such as data files that form the contents of the package

The Data Package metadata is stored in a "descriptor". This descriptor is what makes a collection of data a CLARITY Data Package. The structure of this descriptor is the main content of the specification.

In addition to this descriptor a data package will include other resources such as data files. The CLARITY Data Package specification **does impose** some particular requirements on their form or structure -- in contraposition to the lack of any requirements in the original Data Package specification -- and it also extends the descriptor with additional properties which ensure that data contained in a CLARITY Data Package is valid and suitable for being ingested by CLARITY Climatic Services.

The data included in the package may be provided as:
* Files bundled locally with the package descriptor
* Remote resources, referenced by URL


A typical CLARITY Data Package would be according to the following structure:

```
datapackage.json  # (required) metadata and schemas for this CLARITY data package
README.md         # (optional) README file (in markdown format) describing the purpose of this data package

# data files MUST go in "data" subdirectory (this subdirectory may have additional subdirectories for further
# organizing the datasets in the data package\n
data/mydata.csv
data/hazards/heat-waves/summer-days-index.tif

# the directory for code scripts (by convention scripts go in a scripts directory) for processing or 
# analyzing the data
scripts/my-preparation-script.py
```

## Specification
Detailed specification of CLARITY Data Package can be found in 'docs' folder: https://github.com/clarity-h2020/data-package/tree/master/docs

