# Table of contents
=================
<!--ts-->
   * [Introduction](#Introduction)
   * Dependencies](#Dependencies)
   * [Running tests](#running-tests)
<!--te-->

# Introduction
This model will serve as the basis for building new automated front-end tests using the robot framework. The architecture proposed here aims to facilitate the standardization of projects and the exchange of information.

# Dependencies
The environment needs to have [Python](https://www.python.org/downloads/) installed and we recommend using [VSCode](https://code.visualstudio.com/) as the default editor in our front-end automation project.

**To install, navigate to the robot framework directory, then run:
```bash
$ pip install -r requirements.txt
```

# Running tests
Navigate to the TestSuite directory, then run:
```bash
$ robot -d ..\Results\ -i <tag> .
$ robot -d ..\Results\ -i "Serverest" .
```

### 🛠 Technologies
The following tools were used to build the project:

- [Python](https://www.python.org/downloads/)
- VSCode](https://code.visualstudio.com/)
