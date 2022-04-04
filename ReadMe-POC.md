### Proof of Concept - Objectives

1. Run robot tests in CircleCI / Orbs
    - Dockerfile built, image built and published to dockerhub
    - CircleCI configured to use this image, currently with error, work in progress

2. Run tests in parallel
    - docker file contains env variable which can be passed in via CI to adjust parrallel runs:
`ENV ROBOT_THREADS 1`
    - pabot can be used to pass additional test config variables e.g. smoke tests only
    - consider using https://pypi.org/project/robotframework-circlecilibrary/ to trigger pipelines
    
3. Start tests on a chron job
    - see config.yml and `nightly`

4. Launch tests from CircleCI interface
    - will demo how to do this