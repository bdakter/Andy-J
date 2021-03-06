# Given the following data structures. Write a program that moves the
# information from the array into the empty hash that applies to the correct
# person.

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# ANSWER

contact_data.each do |profile|
  # get the person's first name
  first_name = profile.first.split("@").first.capitalize
  # find the contact hash based on first name
  contacts.each do |k, v|
    # if match is found, add info to hash and break loop (don't add info to more
    # than one profile)
    if /#{first_name}/ =~ k
      contacts[k][:email] = profile[0]
      contacts[k][:address] = profile[1]
      contacts[k][:phone] = profile[2]
      break
    end
  end
end

p contacts
