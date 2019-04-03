for $c in doc("vehicle.xml")
where ends-with($c/Vehicle/registration, "3456")

return <RegistrationData>
  {$c/Vehicle/registration}
</RegistrationData>