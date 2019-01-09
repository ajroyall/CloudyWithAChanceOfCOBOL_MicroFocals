# COBOL Cloud Demo

## The Solution
* mfocal_native - The original Micro Focals application (native COBOL with COBOL data files and console UI)
* GetOneStore - Managed COBOL module with the minimal set of sources and data files needed to get stores information. Created using COBOL Analyzer.
* GetStoreInfo - C# Azure Function that passes a (partial) store name to GetOneStore and returns the store information in JSON format
* StoreLocatorWebsite - A simple HTML site that connects to GetStoreInfo on Azure and display information and a map of a requested store
* ApplicationSliceFromCOBOLAnalyzer - A folder that contains all the needed sources for GetOneStore (created by COBOL Analyzer)

## Demo steps
1. Clone repository
2. Run mfocal_native and show how to get to the store information (M, M, E) 
3. Open COBOL Analyzer, show inventory, show data flow find getonestore, show call map with filer incoming > 15, find getonestore_test
4. Create project from getonestore_test with all referenced and export sources
5. Create a managed COBOL project, add all sources from export, check expose group linkage items to managed code (needed for later)
6. Choose getonestore_test to be the startup object
7. add new folder: gb and add the stores.dat file from mfocal_native\gb into the new folder, set the property: copy if newer on the resource
8. Run and show how it works (returns the store information). We'll now create an Azure function that will use this module.
9. Create an Azure Function named GetStoreInfo (access anonymous would make things easier)
10. Build it
11. Make changes to call GetOneStore from GetStoreInfo Azure Function ([see commit](https://dev.azure.com/GuySofer/_git/CloudyWithAChanceOfCOBOL_MicroFocals/commit/c7f372351627cabb8de9468ac55b1c86b22f6133?refName=refs%2Fheads%2Fmaster))
12. Change startup project to GetStoreInfo and run debugger!
13. Let's deploy on the cloud!
14. Make changes needed for deployment on the cloud. Missing file handler assemblies and changing the current dir ([see commit](https://dev.azure.com/GuySofer/_git/CloudyWithAChanceOfCOBOL_MicroFocals/commit/8631a3a1f486cba95db73104931fd99f5ba50006?refName=refs%2Fheads%2Fmaster))
15. Publish from VS
16. On the Azure portal, set the right application settings: MF_DOTNET_PLATFORM=Azure, MFOCALDIR=../gb, CORS disabled for later
17. You can call from HTTP and show with a JSON viewer
18. Run the little website from the solution (make sure you update the GetJSON call address in main.js)
19. Now that we use .NET COBOL, we can use .NET string for example. Uncomment the ToUpper code snippet in getonestore_test.cbl 
20. Follow the entire CI/CD pipeline in Azure DevOps and show the change in the simple website
21. What else? 
* Unit test 
* Coding standards
* App documentation

## Notes
* It's good to start with an overview of the demo and showing the start and end result
* You can use Demo presentation.pptx (still needs updating, it's just one slide currently)
* Should think of when to show and explain the Azure DevOps pipeline before step 20. Probably make some commits along the way and explain and show what happens in the pipeline and how simple it is to set up
* It's still work in progress...