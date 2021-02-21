if (!(Test-Path -Path "$PSScriptRoot\Img")){
Write-Host "Image directory is missing. Please unzip it before running this script."
Write-Host "The script is expecting the `"Img`" directory to be in the same directory where the script is being run."
Write-Host "Also be sure to add your Market ID in the script....."
break}


$response = Invoke-WebRequest -Uri 'https://linode.ghazlawl.com/ark/mods/auctionhouse/api/json/v1/auctions/?MarketID=[YOUR-MARKET-ID-HERE]' -UseBasicParsing
$Auctions = $response | ConvertFrom-Json
$Eggfile = "$PSScriptRoot/EggListings.html"
$Itemfile = "$PSScriptRoot/ItemListings.html"
$Dinofile = "$PSScriptRoot/DinoListings.html"
$indexfile = "$PSScriptRoot/index.html"
$Dinoheader = @'
<!DOCTYPE html>
<html>
<head>
	<body style="background-color:#666;">
<style>
img{
max-width:50%;
max-height:50%
}
table {
  font-family: Quicksand, Jura;
  color:GhostWhite;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid black;
  text-align: left;
  text-decoration-color: white;
  text-shadow: currentColor;
  padding: 8px;
}
tr{
  background-color: #666;
}
</style>
</head>
<body>
<button type="button" onclick=window.location.href="EggListings.html">Egg Listings</button><br>
<button type="button" onclick=window.location.href="ItemListings.html">Item Listings</button>
<h2 style="color:GhostWhite;text-align: center;text-shadow: 2px 2px black">Dinos on the AH</h2>
<table style="width:100\%">
  <tr>
    <th>Seller</th>
    <th>Dino Type</th> 
    <th>Asking Item</th> 
    <th>Asking Amount</th>
    <th>Stats</th>
    <th>Levels</th>
  </tr>
'@
$Dinoheader|Out-File $Dinofile -Force
$Eggheader = @'
<!DOCTYPE html>
<html>
<head>
	<body style="background-color:#666;">
<style>
img{
max-width:50%;
max-height:50%
}
table {
  font-family: Quicksand, Jura;
  color:GhostWhite;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid black;
  text-align: left;
  text-decoration-color: white;
  text-shadow: currentColor;
  padding: 8px;
}
tr{
  background-color: #666;
}
</style>
</head>
<body>
<button type="button" onclick=window.location.href="DinoListings.html">Dino Listings</button><br>
<button type="button" onclick=window.location.href="ItemListings.html">Item Listings</button>
<h2 style="color:GhostWhite;text-align: center;text-shadow: 2px 2px black">Eggs on the AH</h2>
<table style="width:100\%">
  <tr>
    <th>Seller</th>
    <th>Egg Type</th> 
    <th>Asking Item</th> 
    <th>Asking Amount</th>
  </tr>
'@
$Eggheader|Out-File $Eggfile -Force
$Itemheader = @'
<!DOCTYPE html>
<html>
<head>
	<body style="background-color:#666;">
<style>
img{
max-width:50%;
max-height:50%
}
table {
  font-family: Quicksand, Jura;
  color:GhostWhite;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid black;
  text-align: left;
  text-decoration-color: white;
  text-shadow: currentColor;
  padding: 8px;
}
tr{
  background-color: #666;
}
</style>
</head>
<body>
<button type="button" onclick=window.location.href="DinoListings.html">Dino Listings</button><br>
<button type="button" onclick=window.location.href="EggListings.html">Egg Listings</button>
<h2 style="color:GhostWhite;text-align: center;text-shadow: 2px 2px black">Items on the AH</h2>
<table style="width:100\%">
  <tr>
    <th>Seller</th>
    <th>Item</th>
    <th>Quantity</th> 
    <th>Asking Item</th> 
    <th>Asking Amount</th>
    <th>Stats</th>
  </tr>
'@
$Itemheader|Out-File $Itemfile -Force

$footer = @'
  </table>

</body>
</html>
'@


foreach ($Auction in $Auctions.Auctions){
$AuctionType = $Auction.Type
$Seller = $Auction.Seller.Name
$Item = $auction.Name
$ItemArkName = $Auction.SellingClass
#$ItemLink = "$Item<br><img src=`"./img/$ItemArkName.png`">"
$ItemQuantity = $Auction.Quantity
$PriceItemName = $Auction.AskingClass -replace "PrimalItemResource_","" -replace "_C","" -replace "PrimalItemConsumable_",""
if ($PriceItemName -eq "AmmoniteBlood"){$PriceItemName = "Ammonite Bile"}
if ($PriceItemName -eq "JellyVenom"){$PriceItemName = "Bio Toxin"}
if ($PriceItemName -eq "Gem_BioLum"){$PriceItemName = "Blue Gem"}
if ($PriceItemName -eq "ChitinPaste"){$PriceItemName = "Cementing Paste"}
if ($PriceItemName -eq "Gem_Element"){$PriceItemName = "Red Gem"}
if ($PriceItemName -eq "Polymer_Organic"){$PriceItemName = "Organic Polymer"}
if ($PriceItemName -eq "Silicon"){$PriceItemName = "Silica Pearls"}
$PriceItem = $Auction.AskingClass
$PriceItem = "$PriceItemName<br><img src=`"./img/Items/$PriceItem.png`"> "
$PriceQuantity = $Auction.AskingAmount
if ($AuctionType -eq "Dino"){
$ItemCellDino = @'
<tr>
    <td>Seller</td>
    <td>Dino</td>
    <td>PriceItem</td>
    <td>PriceQuantity</td>
    <td><p>Stats</p></td>
    <td>Levels</td>
  </tr>
'@
if($Item -eq "Grifo"){$Item = "Griffin"}
$Level = $Auction.Dino.Level
$Tamed = $Auction.Dino.BaseLevel
$Gender = $Auction.Dino.Gender
$Stats = ($Auction.Dino.Stats)
$Fixed = ($Auction.Dino.Flags.IsNeutered)
$ItemLink = "$Item<br><img src=`"./img/Dinos/$ItemArkName.png`">"
$Levels = "Gender: $Gender <br>Nutered: $Fixed<br>Tamed Level: $Tamed<br> Current Level: $Level <br> "
$HP = (($Stats.Health)|Out-String).Split('.')[0]
$ST = (($Stats.Stamina)|Out-String).Split('.')[0]
$OX = (($Stats.Oxygen)|Out-String).Split('.')[0]
$FD = (($Stats.Food)|Out-String).Split('.')[0]
$WT = (($Stats.Weight)|Out-String).Split('.')[0]
$DMG = ($Stats.Damage)
$SPD = (($Stats.Speed)|Out-String).Split('.')[0]
if($Item -match "Wyvern"){
[int]$BaseDmg = ((Get-Content $PSScriptRoot\BaseDamage.txt|Select-String "Wyvern") -split ",")[1]
}
else{
[int]$BaseDmg = ((Get-Content $PSScriptRoot\BaseDamage.txt|Select-String "$item") -split ",")[1]
}
$DMG = ($Level*5/100*$DMG*$BaseDmg)
$Stats = "Health: $HP<br>Stam: $ST<br> Weight: $WT<br> Damage (Inaccurate) : $DMG<br> Oxygen: $OX<br> Food: $FD<br>"
$ItemCellDino = $ItemCellDino -replace "Seller","$Seller" -replace "Dino","$ItemLink" -replace "PriceItem","$PriceItem" -replace "PriceQuantity","$PriceQuantity" -replace "Stats","$Stats" -replace "Levels","$Levels"
$ItemCellDino |Out-File $Dinofile -Append
}
if ($AuctionType -eq "Egg"){
$ItemCellDino = @'
<tr>
    <td>Seller</td>
    <td>Dino</td>
    <td>PriceItem</td>
    <td>PriceQuantity</td>
  </tr>
'@
$Level = $Auction.Dino.Level
$Tamed = $Auction.Dino.BaseLevel
$Gender = $Auction.Dino.Gender
$Stats = ($Auction.Dino.Stats)
$ItemLink = "$Item<br><img src=`"./img/Eggs/$ItemArkName.png`">"
$ItemCellDino = $ItemCellDino -replace "Seller","$Seller" -replace "Dino","$ItemLink" -replace "PriceItem","$PriceItem" -replace "PriceQuantity","$PriceQuantity" -replace "Stats","$Stats" -replace "Levels","$Levels"
$ItemCellDino |Out-File $Eggfile -Append
}
if ($AuctionType -eq "Item"){
$ItemCellDino = @'
<tr>
    <td>Seller</td>
    <td>ForSaleItem</td>
    <td>ForSaleQuantity</td>
    <td>PriceItem</td>
    <td>PriceQuantity</td>
    <td><p>Stats</p></td>
  </tr>
'@
$ForSaleItem = ""
$ForSaleItem = $auction.Name
$ForSaleQuantity = $Auction.Quantity
$IsBluePrint = $Auction.Item.Flags.IsBlueprint
if ($IsBluePrint){
$ForSaleItem = "<p style=`"color:CornflowerBlue;`">$ForSaleItem BluePrint</p>"
}
$ForSaleItemLink = "$ForSaleItem<br><img src=`"./img/Items/$ItemArkName.png`">"
$Stats = ($Auction.Item.Stats)
$Levels = "Gender: $Gender <br>Nutered: $Fixed<br>Tamed Level: $Tamed<br> Current Level: $Level <br> "
$CraftedSkillBonus = ($Stats.CraftedSkillBonus)
if (!$CraftedSkillBonus){$CraftedSkillBonus = "N\A"}
$Armor = ($Stats.Armor)
if (!$Armor){$Armor = "N\A"}
$MaxDurability = ($Stats.MaxDurability)
if (!$MaxDurability){$MaxDurability = "N\A"}
$Damage = ($Stats.Damage)
if (!$Damage){$Damage = "N\A"}
$HypothermalInsulation = ($Stats.HypothermalInsulation)
if (!$HypothermalInsulation){$HypothermalInsulation = "N\A"}
$HyperthermalInsulation = ($Stats.HyperthermalInsulation)
if (!$HyperthermalInsulation){$HyperthermalInsulation = "N\A"}
$Stats = "CraftedSkillBonus: $CraftedSkillBonus<br>Armor: $Armor<br> MaxDurability: $MaxDurability<br> Damage: $Damage<br> HypothermalInsulation: $HypothermalInsulation<br> HyperthermalInsulation: $HyperthermalInsulation<br>"
$ItemCellDino = $ItemCellDino -replace "Seller","$Seller" -replace "ForSaleItem","$ForSaleItemLink" -replace "ForSaleQuantity","$ForSaleQuantity" -replace "PriceItem","$PriceItem" -replace "PriceQuantity","$PriceQuantity" -replace "Stats","$Stats"

$ItemCellDino |Out-File $Itemfile -Append
}
}


$footer|Out-File $Dinofile -Append
$footer|Out-File $Eggfile -Append
$footer|Out-File $Itemfile -Append
Copy-Item -Force $Dinofile $indexfile
