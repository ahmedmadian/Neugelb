# Neugelb

This repository contains a demo for sample iOS App, An app designed with help of **VIPER** architecture.

## Getting Started

### Step 1: Clone Repository

Clone the repository by executing the following command from the terminal.

```bash
git clone https://github.com/ahmedmadian/Neugelb.git
```

### Step 3: Build and Run

![](movies.gif) <br />

### Dependency Graph

According to VIPER Architecture, every module have 5 main parts, The main parts of each module are:

**View -** Displays what it is told to by the Presenter and relays user input back to the Presenter. <br /><br />
**Interactor -** Contains business logic as specified by a use case. <br /><br />
**Presenter -** Contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor). <br /><br />
**Entity -** Contains basic model objects used by the Interactor. <br /><br />
**Routing -** Contains navigation logic for describing which screens are shown in which order. <br /><br />
