for $s in doc("vehicle.xml")/Vehicle/Owner/Driver/person
where $s/penaltyPoints = 75

return <details>
  {$s/personalInfo}
</details>