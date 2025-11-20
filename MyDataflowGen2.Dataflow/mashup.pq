[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "publicholidays_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared publicholidays = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "36459d00-c623-4645-a1b9-9cd31f61eb1e"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "1e02d04c-e16b-431e-a447-5651d8516920"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "publicholidays", ItemKind = "Table"]}[Data],
  #"Filtered rows" = Table.SelectRows(#"Navigation 2", each ([countryOrRegion] = "United States")),
  #"Renamed columns" = Table.RenameColumns(#"Filtered rows", {{"date", "holidayDate"}})
in
  #"Renamed columns";
shared publicholidays_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "36459d00-c623-4645-a1b9-9cd31f61eb1e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "1e02d04c-e16b-431e-a447-5651d8516920"]}[Data],
  TableNavigation = Navigation_2{[Id = "usPublicholidays", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
