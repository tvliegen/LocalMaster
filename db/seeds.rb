Claim.create!([
  {tekcare_number: Faker::Number.number(5), title: "Broken Spokes", project: "Wheelbuilder", created_by: Faker::Name.name, status: "in_progress"},
  {tekcare_number: Faker::Number.number(5), title: "Cracked Carbon", project: "Framebuilder", created_by: Faker::Name.name, status: "in_progress"},
  {tekcare_number: Faker::Number.number(5), title: "Crank stripped", project: "Welding", created_by: Faker::Name.name, status: "in_progress"},
  {tekcare_number: Faker::Number.number(5), title: "Broken Hub", project: "Wheelbuilder", created_by: Faker::Name.name, status: "in_progress"},
  {tekcare_number: Faker::Number.number(5), title: "Cracked Light", project: "Accessories", created_by: Faker::Name.name, status: "in_progress"},

  {tekcare_number: Faker::Number.number(5), title: "Wrong Seat", project: "Accessories", created_by: Faker::Name.name, status: "clarification"},
  {tekcare_number: Faker::Number.number(5), title: "New Bar Tape", project: "Accessories", created_by: Faker::Name.name, status: "clarification"},

  {tekcare_number: Faker::Number.number(5), title: "Tire puncture", project: "Accessories", created_by: Faker::Name.name, status: "resolved"},
  {tekcare_number: Faker::Number.number(5), title: "Seat post", project: "Accessories", created_by: Faker::Name.name, status: "resolved"},
  {tekcare_number: Faker::Number.number(5), title: "New Pedals", project: "Accessories", created_by: Faker::Name.name, status: "resolved"}
])
