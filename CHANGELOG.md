# Changelog
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.1.0 (2021-02-24)
### Added
- TE-some text

## 1.1.0 (2021-02-18)
### Added
- TE-9168: configmap reload strategy

## 1.22.0 (2021-02-17)
### Added
- TE-9616: Adding custom container resources

## 1.21.0 (2021-02-16)
### Added
- TE-9575: Automatically add release version to changelog

## 1.14.0 
### Added
- TE-8873: Add ServiceMonitor resource

## 1.13.0
### Added 
- TE-9081:  Create and name multiple ports for application and service: section `deploy`,
            Determine livenessProbe, readinessProbe,
            Remove section service from global settings. Service port definition in section: `external.mappings.port`

## 1.12.0
### Added
- TE-5581: Update ingress subchart to move apikeys to secrets

## 1.11.0
### Added
- TE-1082: Add JSON logging

## 1.10.0
### Added
- TE-5647: Remove ExternalSecret POC

## 1.9.0
### Added
- TE-1010: Add Kubernetes secrets example

## 1.8.0
### Removed
- TRIBE-40003: Remove service and deploy resources

## 1.7.0
### Added
- TRIBE-38790: Library enhancements to support IAM profiles and roles

## 1.6.0
### Added
- TRIBE-38811: Support JWT Authentication

## 1.5.0
### Updated
- TRIBE-38325: Update nexus config

## 1.4.0
### Added
- TRIBE-40491: Spring implementation for graceful shutdown and health probes
### Updated
- TRIBE-40491: Update starter pom to major release

## 1.3.0
### Added
- TRIBE-39733: Make K8s configmap namespaces dynamically for Spring Cloud K8s config

## 1.2.0
### Added
- TRIBE-40424: Add integration tests
 
## 1.1.0
### Added
- TRIBE-39913: Adding egress dependency and renaming global variables

## 1.0.1
### Updated
- TRIBE-39896: Change ambassador-apikey-authentication namespaces

## 1.0.0 
### Added
- Initial version 
- Refactoring helm charts to use dynamic namespace creation and dynamic routing/mapping
- Added OpenAPI
- Gracefulshutdown implemented
- Example added for Spring Cloud k8s condig
- Updated best practices
 