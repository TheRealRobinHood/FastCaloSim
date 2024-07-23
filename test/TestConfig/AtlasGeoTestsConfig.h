#pragma once

#include <TRandom.h>
#include <gtest/gtest.h>

class AtlasGeoTestsConfig : public ::testing::Environment
{
public:
  // The location of the ATLAS calo geometry file
  inline static const std::string ATLAS_CALO_CELL_PATH =
      std::string(TEST_BASE_DIR) + "/data/geometry/ATLASCaloCells.root";
  // The name of the tree in the ATLAS calo geometry file
  inline static const std::string ATLAS_CALO_CELL_TREE_NAME = "caloDetCells";
  // The number of random points that will be generated within a cell for
  // testing lookup
  inline static const int N_RANDOM_POINTS = 100;

  // Helper method to normalize an angle to the range [-pi, pi]
  static auto normalize_angle(double angle) -> double
  {
    angle = std::fmod(angle + M_PI, 2.0 * M_PI);
    if (angle < 0) {
      angle += 2.0 * M_PI;
    }
    return angle - M_PI;
  }

  // Helper method to sample a random number between a and b
  static auto sample(float a, float b) -> float
  {
    return a + (b - a) * gRandom->Rndm();
  }

  // Helper struct to store the hit position
  struct HitPos
  {
    float m_eta, m_phi, m_r, m_x, m_y, m_z;

    auto eta() const -> float { return m_eta; }
    auto phi() const -> float { return m_phi; }
    auto r() const -> float { return m_r; }
    auto x() const -> float { return m_x; }
    auto y() const -> float { return m_y; }
    auto z() const -> float { return m_z; }
  };
};
