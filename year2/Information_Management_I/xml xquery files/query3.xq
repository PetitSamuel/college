for $w in doc("driver.xml")/Driver ,
$x in doc("policy.xml")/policy

where $w/@idNumber = $x/customer/@idNumber

return 
<PolicyInformation>
  {$w/@idNumber}
  {$x/customer/policyInfo/cover}
  {$x/customer/policyInfo/startDate}
  {$x/customer/policyInfo/endDate}
</PolicyInformation>