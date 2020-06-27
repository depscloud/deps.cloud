---
title: Extractor
type: swagger
weight: 40
date: 2020-06-12
---

* Repository: https://github.com/depscloud/extractor
* Runtime: [NodeJS](https://nodejs.org/en/)
* Language: [TypeScript](https://www.typescriptlang.org/)

## Background

The extractor is a NodeJS process written in TypeScript.
This was an intentional design decision when it came to writing this part of the system.
In previous implementations, attempting to work with manifest files in a strongly typed language proved to be rather tedious.
As a result, it inspired the use of a more scientific language where there is more flexibility around the data types we're working with.
While both JavaScript and Python afforded the flexibility I was looking for in a system, it was Typescript that offered the best of both worlds.

## Contributing an extractor

This is by far, one of the easiest ways to contribute to the project.
It involves adding a new class to the code base under the [`src/extractors`](https://github.com/depscloud/extractor/tree/main/src/extractors) directory.
Once the new extractor is added, you can register it using the [`ExtractorRegistry`](https://github.com/depscloud/extractor/blob/main/src/extractors/ExtractorRegistry.ts).
The following code snippet illustrates the bare elements needed to write a custom extractor.

```typescript
export default class FileExtractor implements Extractor {
    public requires(): string[] {
        return [ "my-file.ext" ];
    }

    public async extract(_: string, files: { [p: string]: ExtractorFile }): Promise<DependencyManagementFile> {
        const {
            ...
        } = files["my-file.ext"].json();

        const allDependencies = [];

        return {
            language: Languages.NODE,
            system: "my-system",
            organization,
            module,
            version,
            dependencies: allDependencies,
        };
    }
}
```

## Swagger Explorer

By leveraging the grpc-gateway project, we're able to easily generate Swagger documentation for the API.
This allows you to leverage the Swagger UI to easily browse the API and it's operations.
For convenience, this has been embedded below.

{{< swaggerui src="https://api.deps.cloud/swagger/v1alpha/extractor/extractor.swagger.json" >}}
