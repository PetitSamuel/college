let $s := "2018-11-15"
let $e := "2019-11-19"

for $p in doc("policy.xml")/policy/customer/policyInfo/startDate
for $q in doc ("policy.xml")/policy/customer/policyInfo/endDate
where $s = $p and $e = $q
return 
$p and $q