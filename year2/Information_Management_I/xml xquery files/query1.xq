for $w in doc("company.xml")/company/branch/local_branch/department/employee ,
$x in doc("Customer Support.xml")/CustomerSupport/employee

where $w/firstname = $x/employee.personalInfo/employee.firstName

return <employeeContactDetails>
  {$w/firstname}
  {$w/lastname}
  {$x/employee.contactDetails/employee.phoneNumber}
  {$x/employee.contactDetails/employee.email}
</employeeContactDetails>