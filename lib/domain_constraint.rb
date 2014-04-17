class DomainConstraint
  def initialize(domain)
    @domains = Economy.all.map(&:domain)
  end

  def matches?(request)
    @domains.include?("http://#{request.host_with_port}")
  end
end