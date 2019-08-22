# NIST CVE Feed Checker

Checks for new publications of CVEs from NIST
## Resource Type Configuration
```
resource_types:
- name: nist-feed-check
  type: docker-image
  source:
    repository: nist-feed-check-resource
    tag: latest
```

## Source Configuration
- `feed`: (required) A tag (year, 'recent' or 'modified') to query fron the NIST JSON feeds.

## `check`: Emits updated SHA256 of the requested feed
 
## `in`: Emits the SHA256 as a file named `${feed}.sha256`
 
## `out`: This resource can not produce a `put`
## Examples ##
Trigger a Docker image build from this resource
```
resource_types:
- name: nist-feed-check
  type: docker-image
  source:
    repository: nist-feed-check-resource
    tag: latest

resources:
- name: nist-feed-updated
  type: nist-feed-check
  source:
    feed: modified

jobs:
- name: build-cve-check-image
  plan:
  - get: nist-feed-check
    trigger: true
  - task: build-image
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: google/cloud-sdk
          tag: alpine
      run:
        path: /bin/sh
        args:
        - -exc
        - |
          docker build -t cve-check-image:latest .
```