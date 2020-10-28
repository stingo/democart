module ApplicationHelper
def avataryze(name)
    as_array = name.split(' ')
    if as_array.length >= 2 then (as_array[0][0] + as_array[1][0]).upcase else name[0..1].upcase end
  end
end
