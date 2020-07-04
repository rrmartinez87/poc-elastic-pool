Sku name allowed values
-----------------------

BASIC -> BasicPool
STANDARD -> StandardPool
PREMIUM -> PremiumPool
GENERAL PURPOSE -> GP_Gen4, GP_Gen5
BUSINESS CRITICAL -> BC_Gen4, BC_Gen5


//--- SERVICE TIERS - RESOURCE LIMITS
//------------------------------------

Basic
-----
50, 100, 200, 300, 400, 800, 1200, 1600 DTUs
4.88 GB - 156.25 GB (automatically set)
Per DB -> 0 - 5 DTUs

Standard
--------
50, 100, 200, 300, 400, 800, 1200, 1600, 2000, 2500, 3000 DTUs
50 GB - 4 TB
Per DB -> 10 - 3000 DTUs

Premium
-------
125, 250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000 DTUs
50 GB - 4 TB
Per DB -> 25 - 4000 DTUs
Zone redundant -> false by default

General Purpose
---------------
2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 24, 32, 40, 80 vCores.
8 GB - 4 TB
Per DB -> 0 - vCores selected

Business Critical
-----------------
4, 6, 8 10, 12, 14, 16, 18, 20, 24, 32, 40, 80 vCores.
8 GB - 4 TB
Per DB -> 0 - vCores selected
Zone redundant -> false by default