--Library for crazy map omg
Create = function(class)
	return function(properties)
		local ins = Instance.new(class)
		for key, val in next, properties do
			if type(key) == "number" and typeof(val) == "Instance" then
				val.Parent = ins
				continue;
			end
			ins[key] = val
		end
		return ins;
	end;
end

return {
	init = function(self, ...)
		local colour, transparency, material, size, centre, rows, distance = ...
		self.base = Create("Part"){
			BrickColor = BrickColor.new(colour),
			Transparency = transparency,
			Material = material,
			Size = size,
			Anchored = true
		}
		self.baseparent = Create("Folder"){
			Name = "PartHolder",
			
			Parent = workspace
		}
		
		self.grid = {}
		
		local lowestx, lowestz = (centre.X - (distance * rows)), (centre.Z - (distance * rows));
		local y = centre.Y
		
		local currentv3 = Vector3.new(lowestx, y, lowestz)
		for i = 0, rows - 1 do
			self.grid[i + 1] = {}
			currentv3 = currentv3 + Vector3.new(0, 0, i * distance)
			table.insert(self.grid[i + 1], currentv3)
			for i2 = 1, rows - 1 do
				local v3 = currentv3 + Vector3.new(0, 0, i * distance)
				if v3 == centre then continue; end;
				table.insert(self.grid[i + 1], v3)
			end
		end
		
	end,
	
	CreateTestGrid = function(self)
		for _, v3list in next, self.grid do
			for _, pos in next, v3list do
				local part = self.base:Clone()
				part.Position = pos
				self.Parent = self.baseparent
			end
		end
	end,
	
}
