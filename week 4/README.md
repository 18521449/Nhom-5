# Complete The Image Processing Algorithm with Pipeline
## Algorithm to convert RGB to HSV
* R' = R/255
* G' = G/255
* B' = B/255
* Cmax = max(R', G', B')
* Cmin = min(R', G', B')
* Δ = Cmax - Cmin
* ![image](https://user-images.githubusercontent.com/80138548/113434889-f91e5d80-940b-11eb-82f7-004fe3b9b900.png)
* ![image](https://user-images.githubusercontent.com/80138548/113434896-fde31180-940b-11eb-8170-3626a8279cb4.png)
* V = Cmax
## Flow design
* [Flow Chart](https://app.diagrams.net/?fbclid=IwAR1fjrVOX3SCWkY1vKT1b3HXc2fjLFqlScDW--JnYbSywBPbDvmcMNB186E#G1GxThnxqGejAUG-dMLXlUXjfQ_eMaO8ab) 
### Directory Architecture
![image](https://user-images.githubusercontent.com/80138548/113461370-7bc40e80-9446-11eb-92ed-a91e71dd5b56.png)
### Data flow
![image](https://user-images.githubusercontent.com/80138548/113461413-b0d06100-9446-11eb-9979-a7138d4561da.png)
### Design Architecture
![image](https://user-images.githubusercontent.com/80138548/113431291-b8bbe100-9405-11eb-93aa-03c0dd85bb64.png)
### Packing into Blocks
![image](https://user-images.githubusercontent.com/80138548/113432068-ece3d180-9406-11eb-98e3-e2a460aab881.png)
### Packing Architecture
![image](https://user-images.githubusercontent.com/80138548/113461954-f68e2900-9448-11eb-88aa-4395ec255dd7.png)
### Elaborate Synthetic 
![image](https://user-images.githubusercontent.com/80138548/113461142-95b12180-9445-11eb-9ca9-5432f60a4a54.png)
### Post-implementation schematic
![image](https://user-images.githubusercontent.com/80138548/113467419-133c5800-946d-11eb-872d-ef4dee553270.png)
### For Synthesis
![image](https://user-images.githubusercontent.com/80138548/113467356-b6d93880-946c-11eb-8f79-82a500b6cf41.png)
### Power Synthesic
![image](https://user-images.githubusercontent.com/80138548/113467385-eb4cf480-946c-11eb-927f-280f4e2cfcee.png)



