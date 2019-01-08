The following is a list of attributes contained in the general part of the descriptor.

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
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A short url-usable (and preferably human-readable) name of the package. This MUST be lower-case and contain only alphanumeric characters along with ".", "_" or "-" characters. It will function as a unique identifier and therefore SHOULD be unique in relation to any registry in which this package will be deposited (and preferably globally unique).
 
The name SHOULD be invariant, meaning that it SHOULD NOT change when a data package is updated, unless the new package version should be considered a distinct package, e.g. due to significant changes in structure or interpretation. Version distinction SHOULD be left to the version property. As a corollary, the name also SHOULD NOT include an indication of time range covered.</td>
</tr>
<tr>
<td><i><b>id</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>
A property reserved for globally unique identifiers. 

A common usage pattern for Data Packages is as a packaging format within the bounds of a system or platform. In these cases, a unique identifier for a package is desired for common data handling workflows, such as updating an existing package. While at the level of the specification, global uniqueness cannot be validated, consumers using the id property MUST ensure identifiers are globally unique.
 
For the CSIS, we propose to use URLs as a means for ensuring gloabal uniqueness of the data package id. Taking as basis the Identifier String in Data Package Identifier specification (https://frictionlessdata.io/specs/data-package-identifier/#identifier-string), the following examples would be valid data package identifiers :

* A URL that points directly to the datapackage.json file: http://data.myclimateservice.eu/datapackages/clarity-dc4.json
* A URL that points directly to the datapackage: http://github.com/clarity-h2020/datapackages/clarity-dc4 
* A GitHub URL: http://github.com/clarity-h2020/datapackages/clarity-dc4 


Note 1: The 4th example provided in https://frictionlessdata.io/specs/data-package-identifier/#identifier-string (i.e., using the name of the dataset in the Core Datasets registry) would not be supported as it is not a URL, although it would be valid to use something like this (as it is a URL): https://datahub.io/core/clarity-dc4/datapackage.json

Note 2: for the sake of coherence, the "name" attribute value MUST be the same as in the id (according to the examples above, "name" attribute value would "clarity-dc4".

Note 3: adding versioning to the url (pending)</td>
</tr>
<tr>
<td><i><b>version</b></i></td>
<td>Character string</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A version string identifying the version of the package. It should conform to the Semantic Versioning requirements (http://semver.org/) and should follow the Data Package Version pattern (https://frictionlessdata.io/specs/patterns/#data-package-version): MAJOR.MINOR.PATCH (e.g., 1.0.0)</td>
</tr>
<tr>
<td><i><b>profile</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A string identifying the profile of this descriptor as per the profiles specification (https://frictionlessdata.io/specs/profiles/).
 
Different kinds of data need different data and metadata formats. To support these different data and metadata formats we need to extend and specialise the generic Data Package. These specialized types of Data Package (or Data Resource) are termed profiles.
 
Thus, in the context of the CSIS, we define a specialized general Data Package profile. In the same manner, each of the specific resources contained in the "CLARITY Data Package" are defined according to the "CLARITY Data Resource" profile.
 
The value of the profile property is a unique identifier for that profile. This unique identifier MUST be a string in the form of a fully-qualified URL, allowing thus ensuring its uniqueness, that points directly to a JSON Schema that can be used to validate the profile.
 
The profile schema proposed for CLARITY Data Packages is "profile": http://data.myclimateservice.eu/schemas/clarity-data-package-json-schema.json

Note: pending to create clarity-data-package-json-schema.json schema
</td>
</tr>
<tr>
<td><i><b>title</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A string providing a title or one sentence description for this package</td>
</tr>	
<tr>
<td><i><b>description</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A description of the package. The description MUST be markdown formatted -- this also allows for simple plain text as plain text is itself valid markdown. The first paragraph (up to the first double line break) should be usable as summary information for the package.</td>
</tr>
<tr>
<td><i><b>keywords</b></i></td>
<td>List of character strings without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>An array of string keywords characterizing the package, assisting users searching for it in catalogs.</td>
</tr>
<tr>
<td><i><b>created</b></i></td>
<td>DateTime</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The datetime on which this was created.
 
Note: semantics may vary between publishers -- for some this is the datetime the data was created, for others the datetime the package was created. In CLARITY Data Packages, it refers to the datatime when the data package was created. The datetime must conform to the string formats for datetime as described in RFC3339 (https://tools.ietf.org/html/rfc3339#section-5.6).

Example: { "created": "2018-09-20T23:20:50.52Z" }"</td>
</tr>
<tr>
<td><i><b>homepage</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>A URL for the home on the web that is related to this data package.</td>
</tr>
<tr>
<td><i><b>sources</b></i></td>
<td>List of Source objects</td>
<td>0*</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>The raw sources for this data package. 
It MUST be an array of Source objects. Each Source object MUST have a title and MAY have path and/or email properties.

Example: "sources": [{ "title": "World Bank and OECD", "path": "http://data.worldbank.org/indicator/NY.GDP.MKTP.CD" }]"
</td>
</tr>
<tr>
<td><i><b>contributors</b></i></td>
<td>List of Contributor objects</td>
<td>0*</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The people or organizations who contributed to this Data Package. It MUST be an array. Each entry is a Contributor and MUST be an object. A Contributor MUST have a title property and MAY contain path, email, role and organization properties.

Example: "contributors": [{ "title": "Joe Bloggs", "email": "joe@bloggs.com", "path": "http://www.bloggs.com", "role": "author" }]"
</td>
</tr>
<tr>
<td><i><b>licenses</b></i></td>
<td>List of License objects</td>
<td>0*</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>The license(s) under which the package is provided.

This property is not legally binding and does not guarantee the package is licensed under the terms defined in this property.
"licenses" MUST be an array. Each item in the array is a License object. The object MUST contain a name property and/or a path property. It MAY contain a title property.</td>
</tr>
<tr>
<td><i><b>image</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>An image to use for this data package. For example, when showing the package in a listing.
 
The value of the image property MUST be a string pointing to the location of the image. The string must be a url-or-path, that is a fully qualified HTTP address, or a relative POSIX path (see the url-or-path definition in Data Resource for details).</td>
</tr>
<tr>
<td><i><b>resources</b></i></td>
<td>List of Resource objects</td>
<td>1+</td>
<td>MANDATORY</td>
<td>MANDATORY</td>
<td>
The resources property is required, with at least one resource.

Packaged data resources are described in the resources property of the package descriptor. This property MUST be an array of objects. 
Each object MUST follow the Data Resource specification (https://frictionlessdata.io/specs/data-resource/) OR the CLARITY extension of the Data Resource specification for concrete resources needed as input for the CSIS (e.g., Hazard, Exposure, Vulnerability, etc. Maps Resources). 

See CLARITY Resources table for a detailed list of attributes of the object.
 
Note1: According to the Data Resource specification: "A resource MUST contain a property describing the location of the data associated to the resource. The location of resource data MUST be specified by the presence of one (and only one) of these two properties:
 * path: for data in files located online or locally on disk.
 * data: for data inline in the descriptor itself."
 
Note2: CLARITY Data Packages ONLY support resources that describe their location with the "path" property. This is to avoid having Data Package descriptors (.json) files bloated with thousands of text lines enconding the data which would make unamageable and unreadable the descriptor. Instead of that, CLARITY Data Packages forces to store that data in a file and reference it within the Data Package itself or to a remote location.
</td>
</tr>
<tr>
<td><i><b>language</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>N/A</td>
<td>OPTIONAL</td>
<td>
ISO/TS 19139 alpha-3 (three characters) code denoting the language in which the textual information of the metadata is presented. 
IF empty, it is assumed English ("eng")
</td>
</tr>
<tr>
<td><i><b>price</b></i></td>
<td>Price object</td>
<td>0/1</td>
<td>N/A</td>
<td>OPTIONAL</td>
<td>
Price of the datapackage. If empty, then assume that it is free.
</td>
</tr>
</tbody>
</table>

<br/>
<br/>
<u><b>Source object:</b></u>
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
<td><i><b>title</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>title of the source (e.g. document or organization name)</td>
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
<td><i><b>email</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>An email address </td>
</tr>
</tbody>
</table>

<br/>
<br/>
<u><b>Contributor object:</b></u>
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
<td><i><b>title</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>name/title of the contributor (name for person, name/title of organization)</td>
</tr>
<tr>
<td><i><b>path</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A fully qualified http URL pointing to a relevant location online for the contributor.</td>
</tr>
<tr>
<td><i><b>email</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>An email address</td>
</tr>
<tr>
<td><i><b>role</b></i></td>
<td>String enumeration</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>MANDATORY</td>
<td>A string describing the role of the contributor. It MUST be one of: author, publisher, maintainer, wrangler, and contributor. Defaults to contributor.

Note on semantics: use of the "author" property does not imply that that person was the original creator of the data in the data package - merely that they created and/or maintain the data package. It is common for data packages to "package" up data from elsewhere. The original origin of the data can be indicated with the sources property - see above.</td>
</tr>
<tr>
<td><i><b>organization</b></i></td>
<td>Character string without length restriction</td>
<td>0/1</td>
<td>OPTIONAL</td>
<td>OPTIONAL</td>
<td>A string describing the organization this contributor is affiliated to.</td>
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


<br/>
<br/>
<u><b>Price object:</b></u>
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
<td><i><b>amount</b></i></td>
<td>Float</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>The price of the data package. If the data package is free, then the value of this parameter MUST be 0.0</td>
</tr>
<tr>
<td><i><b>currency</b></i></td>
<td>String enumeration</td>
<td>1</td>
<td>N/A</td>
<td>MANDATORY</td>
<td>The currency property of a price is given. It must be one of of the codes listed here: https://www.currency-iso.org/en/home/tables/table-a1.html.
By default, the currency code is "EUR"</td>
</tr>
</tbody>
</table>
