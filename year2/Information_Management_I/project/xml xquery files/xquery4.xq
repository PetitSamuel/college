declare function local:findRegisteredDrivers()
{
for $s in doc("vehicle.xml")/Vehicle
where $s/@id = "50"

return <details>
  {$s/Owner/Driver/person}
</details>
};
<Driver>{local:findRegisteredDrivers()}</Driver>