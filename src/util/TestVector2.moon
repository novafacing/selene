require("src.util.Vector2")
require("busted.runner")()

describe("Vector2", () ->
    describe("Should implement correct mathematical operations", () ->
        it("Should add unit vectors correctly", () -> 
            assert.truthy(Unit() + Unit() == Vector2(2, 2))
        )
        it("Should subtract unit vectors correctly", () ->
            assert.truthy(Unit() - Unit() == Zero())
        )
        it("Should dot vectors correctly", () ->
            assert.truthy(Right()\dot(Right()) == 1)
        )
        it("Should negate vectors correctly", () ->
            assert.truthy(-Right() == Left())
            assert.truthy(-Left() == Right())
            assert.truthy(-Up() == Down())
            assert.truthy(-Down() == Up())
            assert.truthy(-Unit() == Vector2(-1, -1))
        )
        it("Should compute the magnitude correctly", () ->
            assert.truthy(Right()\magnitude! == 1)
        )
    )
)
