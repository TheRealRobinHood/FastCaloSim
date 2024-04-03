#include <string>

#include "FastCaloSim/FastCaloSim.hpp"

exported_class::exported_class()
    : m_name {"FastCaloSim"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
