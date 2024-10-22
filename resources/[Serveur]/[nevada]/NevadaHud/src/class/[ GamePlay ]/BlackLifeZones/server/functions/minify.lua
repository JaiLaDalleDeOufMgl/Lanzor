function _GamemodeZones:minify()
    return {
        id = self.id,
        coords = self.coords,
        
        helpText = self.helpText,

        requireJob = self.requireJob,

        drawDistance = self.drawDistance,
        interactDistance = self.interactDistance
    }
end