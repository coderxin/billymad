class String
  def dasherize
    string = self.dup
    string.gsub!(/::/, '_')
    string.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1-\2')
    string.gsub!(/([a-z\d])([A-Z])/,'\1-\2')
    string.downcase!
    string
  end
end