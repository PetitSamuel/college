for $w in doc("claim.xml")/claim ,
$x in doc("driver.xml")/Driver 

where $w/privateInformation/driverName/firstName = $x/person/personalInfo/firstName

return
<claimInformation>
  {$x/person/personalInfo/firstName}
  {$x/person/personalInfo/lastName}
  {$w/privateInformation/name}
  {$w/privateInformation/synopsis}
  {$w/privateInformation/driverID}
</claimInformation>