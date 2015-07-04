require 'rspec'
require 'array_exercises'
require 'byebug'

describe Array do

  context "when finding my_uniq" do
    it "doesn't alter already unique arrays" do
      expect([1, 2, 3].my_uniq).to eq([1, 2, 3])
    end

    it "finds uniques" do
      expect([1, 1, 2, 3, 3].my_uniq).to eq([1, 2, 3])
    end

    it "doesn't use built-in uniq method" do
      my_array = [1,2,3,4,3]
      expect(my_array).not_to receive(:uniq)
      my_array.my_uniq
    end
  end

  context "when finding two-sums" do
    it "returns an empty array when no pairs" do
      expect([4, 5, 6, 6].two_sums).to eq([])
    end

    it "finds all pairs" do
      expect([-1, 0, 2, -2, 1].two_sums).to eq([[0, 4], [2, 3]])
    end
  end

  context "when finding median" do
    it "finds the median of an odd sized array" do
      expect([3, 7, 10, 11, 13].median).to eq(10)
    end

    it "finds the median of an even sized array" do
      expect([3, 7, 8, 10, 11, 13].median).to eq(9)
    end
  end

  context "when finding transpose" do
    subject(:original_matrix) {[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
      ]}
    let(:transposed_matrix) {original_matrix.transpose}

    it "transposes the array" do
      expect(original_matrix.my_transpose).to eq(transposed_matrix)
    end

    it "does not use the built-in transpose method" do
      expect(original_matrix).not_to receive(:transpose)
      original_matrix.my_transpose
    end
  end
end
