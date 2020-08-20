# web-dockerfiles

This repository holds a collection of Dockerfile for the web development with PHP and Apache.

## Development

All development work occurs on the `develop` branch.
The `master` branch is used to create new releases by merging current head of the `develop` branch.
You should create a feature-branch, branching from `develop`, whenever you need to add some changes to the master branch.
If those changes are accepted they will be merged by maintainer.

## Repository overview

In the following table the relationships among the images are explicated:

| Image                       | Parent Image                | Description                                                                      |
| --------------------------- | -------------------------   | -------------------------------------------------------------------------------- |
| caendra/base:centos7.6      | centos:7.6.1810             | Customized version of CentOS 7.6                                                 |
| caendra/base:centos7.6-ius  | ecarocci/base:centos7.6     | Extension of the parent image with IUS repository                                |
| caendra/base:centos7.7      | centos:7.7.1908             | Customized version of CentOS 7.7                                                 |
| caendra/base:centos7.7-remi | ecarocci/base:centos7.7     | Extension of the parent image with Remi repository                               |

To retrieve more information on the images, the related `README.md` should be checked.
