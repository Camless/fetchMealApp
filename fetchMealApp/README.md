#  Readme

Hi!

Just a couple of things I wanted to point out as you browse through the project.

- The use of the LoadingState enum within views is kind of awkward in SwiftUI. I could have attached an alert sheet to the ProgressView in the .loading case, but then you lack the clarity you get from having three states for a view. I decided to split them up in three, but I could see the case for just having .loading and .loaded.
- I eliminate any missing or nil values for ingredients at the decoding level. It doesn't make sense to have an ingredient without a measurement, or vice versa.
- The MealType is to allow for future introduction of other types of meals (e.g. Entrees, Appetizers, Snacks). In fact, I tried my best to make functions meal-neutral as far as what kind of meal can be processed through them.
- If you'd like to test the error handling for UI, uncomment the comments in the API class.

Thank you for taking the time to look through my project!
- Carlos 
