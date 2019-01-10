The following is a list of attributes contained in the Data Resource section of the the descriptor.

<table>
<thead>
<tr>
<th colspan="3">Attribute</th>
<th colspan="2">Obligation / Condition</th>
<th rowspan="2">Description</th>
</tr>
<tr>
<th>Name</th>
<th>Type</th>
<th>Multiplicity</th>
<th>FrictionlessData</th>
<th>CSIS</th>
</tr>
</thead>
<tbody>
<tr>
<td><i><b>name</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>MANDATORY</td>
<td>MANDATORY</td>
<td>A resource MUST contain a name property. The name is a simple name or identifier to be used for this resource.
 
If present, the name MUST be unique amongst all resources in this data package.
It MUST consist only of lowercase alphanumeric characters plus ""."", ""-"" and ""_"".
It would be usual for the name to correspond to the file name (minus the extension) of the data file the resource describes.
The name SHOULD be invariant, meaning that it SHOULD NOT change when a data package is updated, unless the new package version should be considered a distinct package, e.g. due to significant changes in structure or interpretation. Version distinction SHOULD be left to the version property. As a corollary, the name also SHOULD NOT include an indication of time range covered.</td>
</tr>
<tr>
<td><i><b>profile</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A string identifying the profile of this resource descriptor as per the profiles specification (see the profile property in "General" tab).

For CSIS: http://data.myclimateservice.eu/schemas/clarity-data-resource-json-schema.json
</td>
</tr>
<tr>
<td><i><b>title</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A string providing a title or one sentence description for this resource</td>
</tr>	
<tr>
<td><i><b>description</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A description of the resource package (see the description property in "General" tab).</td>
</tr>
<tr>
<td><i><b>sources</b></i></td>
<td>List of Source objects</td>
<td>1+</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>The raw sources that were used for producing this resource. For further information, please check the sources property description at data package level.
</td>
</tr>
<tr>
<td><i><b>contributors</b></i></td>
<td>List of Contributor objects</td>
<td>0+</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The people or organizations who contributed to produce this resource. For further information, please check the contributors property description at data package level.
</td>
</tr>
<tr>
<td><i><b>licenses</b></i></td>
<td>List of License objects</td>
<td>0+</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The license(s) under which the resource is provided. If not specified the resource inherits from the data package. For further information, please check the license property description at data package level. </td>
</tr>
<tr>
<td><i><b>format</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The value of this property would be expected to be the standard file extension for this type of resource.

Currently, CLARITY Data Package only supports the following resource formats:
 * Tabular data:
    - Comma Separated Values (.csv)
 * Vector based:
    - GeoJson (.geojson)
    - ESRI Shapefiles (.shp)
    - OGC GeoPackage (.gpkg). 
 * Raster based:
    - Geotiff (.tif, .tiff)
 
Note: the use of GeoPackages allows to overcome the limitations of ESRI Shapefiles (Check the list of limitations at http://switchfromshapefile.org/ and https://www.gis-blog.com/geopackage-vs-shapefile) and therefore, its use in Data Packages should be preferrable. Nevertheless, when using GeoPackages as resources within the Data Packages, in order to comply with the Data Package specification, take into account that a resource of this type can only have ONE dataset within the GeoPackage (although its specification allows having one or more different datasets).</td>
</tr>
<tr>
<td><i><b>mediatype</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>The mediatype/mimetype of the resource e.g. ""text/csv"". Mediatypes are maintained by the Internet Assigned Numbers Authority (IANA) in a media type registry (https://www.iana.org/assignments/media-types/media-types.xhtml). 

Note: it is possible that some particular GIS formats are not listed in the media type registry.
</td>
</tr>
<tr>
<td><i><b>encoding</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>Specify the character encoding of the resource's data file. The values should be one of the ""Preferred MIME Names"" for a character encoding registered with IANA (https://www.iana.org/assignments/character-sets/character-sets.xhtml). If no value for this key is specified then the default is UTF-8.

Note: what happens if the resource is a raster?
</td>
</tr>
<tr>
<td><i><b>bytes</b></i></td>
<td>Long</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>Size of the file in bytes. 

Note: This parameter is hepful for determining how to process the Data Package, thus for instance, if we know in advance that several of the resources are large, we can determine that it is better to process the contents in a batch process and later on inform the user when the results are ready.
In this sense, the parameter is considered MANDATORY if the resource is included within the Data Package (the path parameter points to a local file within the Data Package), whereas it is considered OPTIONAL if the path parameter points to a remote location (e.g., HTTP request to a WFS service or ftp location). This is so because the size of the resource is unknown until it is requested to the server hosting it."
</td>
</tr>
<tr>
<td><i><b>hash</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>the MD5 hash for this resource. Other algorithms can be indicated by prefixing the hash's value with the algorithm name in lower-case.

For example: "hash": "sha1:8843d7f92416211de9ebb963ff4ce28125932878"</td>
</tr>
<tr>
<td><i><b>data</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>N/A</td>
<td>Resource data rather than being stored in external files can be shipped 'inline' on a Resource using the data property.

Note: this property is not supported in CSIS Data Package Resources.</td>
</tr>
<tr>
<td><i><b>path</b></i></td>
<td>url-path character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>"Location property for data in files located online or locally on disk (within the Data Package itself).
 
The path property MUST be a string -- or an array of strings (see "Data in Multiple Files"). Each string MUST be a "url-or-path" string, defined as the following:
 * URLs MUST be fully qualified. MUST be using either http or https scheme. (Absence of a scheme indicates MUST be a POSIX path)
 * POSIX paths (unix-style with / as separator) are supported for referencing local files, with the security restraint that they MUST be relative siblings or children of the descriptor. Absolute paths (/) and relative parent paths (../) MUST NOT be used, and implementations SHOULD NOT support these path types.
 
Examples:
 * fully qualified url
   - "path": "http://ex.datapackages.org/big-csv/my-big.csv"
   - "path": "http://demo.geo-solutions.it/geoserver/tiger/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=tiger:tiger_roads&srsName=EPSG:3857&bbox=40.7,-74,40.8,-73,urn:ogc:def:crs:EPSG:4326&maxFeatures=1"

 * relative path (note: this will work both as a relative path on disk and on online)
   - "path": "data/my-csv.csv"
 
 
SECURITY: / (absolute path) and ../ (relative parent path) are forbidden to avoid security vulnerabilities when implementing data package software. These limitations on resource path ensure that resource paths only point to files within the data package directory and its subdirectories. This prevents data package software being exploited by a malicious user to gain unintended access to sensitive information.
 
Data in Multiple Files: Usually, a resource will have only a single file associated to it. However, sometimes it may be convenient to have a single resource whose data is split across multiple files -- perhaps the data is large and having it in one file would be inconvenient.
To support this use case the path property MAY be an array of strings rather than a single string: "path": [ "myfile1.csv", "myfile2.csv" ]
It is NOT permitted to mix fully qualified URLs and relative paths in a path array: strings MUST either all be relative paths or all URLs.
 
Best Practice (proposal): dataset resources MUST be located in a "data" folder in the root of the in a Data Package (where the json descriptor is also located) in order to have a better organization of the contents. Within the data folder, datasets MAY be further organized creating additional subfolders if necessary.</td>
</tr>
<tr>
<td><i><b>schema</b></i></td>
<td>url-path character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>In CLARITY Data Packages, a Data Resource MUST always have a schema property to describe the schema of the resource data.

Note: even for raster-based resources, having the schema is necessary, as it can describe useful information like what is/are the paremeter(s) measured as well as its/their measurement unit(s), which may be necessary for the application in charge of process the resource afterwards.
 
The value for the schema property on a resource MUST be an object representing the schema OR a string that identifies the location of the schema.
If a string it must be a url-or-path as defined above, that is a fully qualified http URL or a relative POSIX path. The file at the location specified by this url-or-path string MUST be a JSON document containing the schema.
 
The next section provide a complete schema description with the parameters for each of the typical resources included in a CLARITY Data Package.</td>
</tr>
<tr>
<td><i><b>quality</b></i></td>
<td>Quality object</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>Check with LUIS
possible parameters:
* uncertainty
* fiability</td>
</tr>
<tr>
<td><i><b>spatial_context</b></i></td>
<td>SpatialContext object</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL(*)</td>
<td>MANDATORY if the resource is a spatial dataset. Otherwise, this property is empty.</td>
</tr>
<tr>
<td><i><b>temporal_context</b></i></td>
<td>TemporalContext object</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL(*)</td>
<td>MANDATORY if the resource is has a temporal component. Otherwise, this property is empty.</td>
</tr>
<tr>
<td><i><b>analysis_context</b></i></td>
<td>AnalysisContext object</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>This property describes contextual information needed by the CSIS in order to understand how to process this specific resource (e.g., in which step of the CSIS workflow it must be used, to which hazard the resource is related to, etc. </td>
</tr>
</tbody>
</table>

<br/>
<br/>
<u><b>SpatialContext object:</b></u>
<table>
<thead>
<tr>
<th colspan="3">Attribute</th>
<th colspan="2">Obligation / Condition</th>
<th rowspan="2">Description</th>
</tr>
<tr>
<th>Name</th>
<th>Type</th>
<th>Multiplicity</th>
<th>FrictionlessData</th>
<th>CSIS</th>
</tr>
</thead>
<tbody>
<tr>
<td><i><b>crs</b></i></td>
<td>CharacterString enumeration</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>Property indicating the Coordinate Reference System. Its value must be a valid EPSG code (https://sis.apache.org/tables/CoordinateReferenceSystems.html). 

By default, CLARITY Data Packages use EPSG:3035

Example:
"crs": "EPSG:3035"
</td>
</tr>
<tr>
<td><i><b>extent</b></i></td>
<td>List of two pairs of coordinates: [xmin, ymin, xmax, ymax]</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>The extent property defines the minimum bounding rectangle (xmin, ymin and xmax, ymax) defined by coordinate pairs of the spatial data resource. All coordinates for the data source fall within this boundary. 

E.g., "extent": [-180.0, -90.0, 180.0, 90.0]
</td>
</tr>
<tr>
<td><i><b>resolution</b></i></td>
<td>SpatialResolution object</td>
<td>1</td>
<td>N/A</td>
<td>MADATORY</td>
<td>The spatial resolution property refers to the level of detail of the data set. It shall be expressed as a resolution distance value (typically for gridded data and imagery-derived products) or an equivalent scale value (typically for maps or map-derived products).

Note 1: An equivalent scale is generally expressed as an integer value expressing the scale denominator. A resolution distance shall be expressed as a numerical value associated with a unit of length.

Note 2: For grids it is assumed that the resolution of the cells is the same in the x and y axis

Examples:
* "resolution": { "scale": 50000 }
* "resolution": { "distance": 12.5, "uom": "km"}
</td>
</tr>
<tr>
<td><i><b>grid_info</b></i></td>
<td>GridInfo object</td>
<td>0/1</td>
<td>N/A</td>
<td>MADATORY(*)</td>
<td>This property is MANDATORY if the resource is a raster. Please, see GridInfo object description for further details.
</td>
</tr>
</tbody>
</table>

<br/>
<br/>
<u><b>GridInfo object:</b></u>
<table>
<thead>
<tr>
<th colspan="3">Attribute</th>
<th colspan="2">Obligation / Condition</th>
<th rowspan="2">Description</th>
</tr>
<tr>
<th>Name</th>
<th>Type</th>
<th>Multiplicity</th>
<th>FrictionlessData</th>
<th>CSIS</th>
</tr>
</thead>
<tbody>
<tr>
<td><i><b>bands</b></i></td>
<td>Integer</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>Number of bands contained in the gridded dataset</td>
</tr>
<tr>
<td><i><b>bit_depth</b></i></td>
<td>CharacterString enumeration</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>The bit depth (also known as pixel depth) of a cell determines the range of values that a particular raster file can store, which is based on the formula 2n (where n is the bit depth). For example, an 8-bit raster can have 256 unique values, which range from 0 to 255.
 
Possible "bit_depth" values for this property are described in the first column of the following table:

<b>Bit depth	           Range of values that each cell can contain</b>
1 bit	                           0 to 1
2 bit	                           0 to 3
4 bit	                           0 to 15
Unsigned 8 bit	           0 to 255
Signed 8 bit	           -128 to 127
Unsigned 16 bit	           0 to 65535
Signed 16 bit	           -32768 to 32767
Unsigned 32 bit	           0 to 4294967295
Signed 32 bit	           -2147483648 to 2147483647
Floating-point 32 bit     -3.402823466e+38 to 3.402823466e+3
</td>
</tr>
<tr>
<td><i><b>columns</b></i></td>
<td>Long</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>This property indicates the number of columns in the grid</td>
</tr>
<tr>
<td><i><b>rows</b></i></td>
<td>Long</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>This property indicates the number of rows in the grid</td>
</tr>
<tr>
<td><i><b>no_data_value</b></i></td>
<td>Character string without length restriction</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>Value used to represent the absence of data in a cell. The value must be in relation to the ranges used with the bit_depth property</td>
</tr>
<tr>
<td><i><b>start_cell</b></i></td>
<td>CharacterString enumeration</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>This property indicates the starting cell of the raster.
Possible values are: top-left, bottom-right
</td>
</tr>
</tbody>
</table>

<br/>
<br/>
<u><b>License object:</b></u>
<table>
<thead>
<tr>
<th colspan="3">Attribute</th>
<th colspan="2">Obligation / Condition</th>
<th rowspan="2">Description</th>
</tr>
<tr>
<th>Name</th>
<th>Type</th>
<th>Multiplicity</th>
<th>FrictionlessData</th>
<th>CSIS</th>
</tr>
</thead>
<tbody>
<tr>
<td><i><b>name</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The name MUST be an Open Definition license ID (see https://licenses.opendefinition.org/)</td>
</tr>
<tr>
<td><i><b>path</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A url-or-path string, that is a fully qualified HTTP address, or a relative POSIX path (see the url-or-path definition in Data Resource for details).</td>
</tr>
<tr>
<td><i><b>title</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>A human-readable title</td>
</tr>
</tbody>
</table>
