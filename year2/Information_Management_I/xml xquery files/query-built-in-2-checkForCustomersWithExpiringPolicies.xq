for $c in doc("policy.xml"),
$x in $c/policy/customer/policyInfo/endDate

where xs:date($x) < current-date() + xs:yearMonthDuration("P3M")

return <data>
  {$c/policy/customer/personalInfo/firstName}
  {$c/policy/customer/personalInfo/lastName}
  {$c/policy/customer/contactDetails/phoneNumber}
  {$c/policy/customer/contactDetails/email}
</data>