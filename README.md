# PokeApp

Pokemon app for listing pokémons. The app shows two screens, a list screen with a list of pokémons by order (first generation, then second, etc) and a detail screen with some of the chosen Pokémon's characteristics.

### App Screens

<img src="./app_list_screen.png" width="45%">
<img src="./app_detail_screen.png" width="45%">


### Architecture

The architecture for this app is a MVVM-C (Model-View-ViewModel-Coordinator) architecture. Coordinator instantiates ViewController and its ViewModel. ViewModel communicates to Coordinator via a protocol. ViewModel owns a PokemonAPI client, which can be changed to a Repository in the case a local data source is added.

### Future improvements

- Mark pokémons as favourites (saving to CoreData or other persistence library)
- Search pokémons functionality in the list screen (or add new screen with search filters)
- Show evolution lines and other details in the details screen
- Add a dependency injection solution
- Add domain and UI layer entities alongside mappers
- More UI refinements
