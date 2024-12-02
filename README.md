# Places

The architecture is based on a modular design following the clean architecture and SOLID principles. The dependency between modules is from the outside in, which means inner modules don't depend on outter modules. There are 7 modules:

- Domain
- Data
- Infrastructure (Networking)
- Application logic (Use case)
- Presentation
- UI
- Composition Root

### Domain
Location entity with the interfaces needed (LocationsRepositoryType, LocationsDomainErrorMapperType) to perform the use cases. 

### Data
RemoteLocationsRepository, which implements the LocationsRepositoryType, and the interfaces what need to be implemented by the Networking engine. 

### Infrastructure (Networking)
Networking engine based on URLSession.

### Application logic (Use case)
Entry point the to execute the business logic. 

### Presentation
LocationsListViewModel which handles the presentation logic needed to present the locations.

### UI
All the UI components based on SwiftUI 

### Composition Root
Factory that has access to all the layers so it can compose everything together and create the Feature.

The feature opens the Wikipedia app which needs to be compiled from [this fork](https://github.com/srehouni/wikipedia-ios) to present the locations on the map. 
