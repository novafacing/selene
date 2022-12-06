require("src.util.Math")
require("busted.runner")()

describe("Math", () ->
    describe("Should implement correct mathematical operations", () ->
        it("Should clamp values to a range", () ->
            assert.truthy(clamp(5, 0, 10) == 5)
            assert.truthy(clamp(-5, 0, 10) == 0)
            assert.truthy(clamp(15, 0, 10) == 10)
        )
    )
)