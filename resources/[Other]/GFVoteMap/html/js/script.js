const doc = document;
const wrapper = doc.getElementById('wrapper');
let votes = {};

this.window.addEventListener('load', e => {
    window.addEventListener('message', e => {
        switch (e.data.action) {
            case 'show':
                wrapper.style.display = 'flex'
            break;
            
            case 'updatevotes':
                votes = e.data.votes;
                UpdateVotes(votes)
            break;

            case 'hide':
                fetch('../config/config.json')
                .then((response) => response.json())
                .then((data) => ResetVotes(data))
                .catch((error) => {console.log('Config Error: ' + error)})
                wrapper.style.display = 'none'
            break;
        }
    })
})

function UpdateVotes(new_votes) {
    new_votes.forEach(function callback(value, index) {
        if(new_votes[index] === null) {
            new_votes[index] = 0
        }
        var to_update = doc.getElementById(index+1);
        to_update.innerHTML = new_votes[index] + ' votes(s)'
    });
}

function ResetVotes(data){
    data.forEach(dataItem => {
        var to_update = doc.getElementById(dataItem.id);
        to_update.innerHTML = '0 votes(s)'
    });
}

this.window.addEventListener('DOMContentLoaded', () => {
    fetch('../config/config.json')
    .then((response) => response.json())
    .then((data) => appendData(data))
    .catch((error) => {console.log('Config Error: ' + error)})
})

// doc.onkeyup = e => {
//     if (e.key == 'Escape') {
//         fetchNUI('getVotingInfo')
//     }
// }

const fetchNUI = async (cbname, data) => {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data)
    };
    const response = await fetch(`https://Gamemode_GFVoteMap/${cbname}`, options);
    return await response.json();
}

function appendData(data, excludeId) {
    const container = doc.getElementById('container');
    data.forEach(dataItem => {
        // if(dataItem.id !== excludeId) {
            const slide = doc.createElement('div');

            const info = doc.createElement('div');
            const infoWave = doc.createElement('div');
            const infoLogo = doc.createElement('img');
            const infoTitle = doc.createElement('span');
            const infoDesc = doc.createElement('span');
    
            const hover = doc.createElement('div');
            const hoverLocation = doc.createElement('span');
            const hoverBtn = doc.createElement('btn');
    
            hoverBtn.addEventListener('click', () => {fetchNUI('getVotingInfo', dataItem.id)})
    
            // Add classes
            hoverBtn.classList.add('info-btn');
            hoverLocation.classList.add('location');
            hover.classList.add('hover-container');
            infoWave.classList.add('job-wave');
            infoLogo.classList.add('job-logo');
            infoTitle.classList.add('title');
            infoDesc.classList.add('description');
            infoDesc.setAttribute("id", dataItem.id)
            info.classList.add('info-container');
            slide.classList.add('job-container');

            if(votes[dataItem.id] === undefined) {
                votes[dataItem.id] = 0
            }
    
            // Set content
            hoverBtn.textContent = 'Voter';
            hoverLocation.textContent = dataItem.place;
            infoTitle.textContent = dataItem.name;
            infoDesc.textContent = votes[dataItem.id] + ' vote(s)';
            infoLogo.src = dataItem.image;
    
            info.append(infoWave, infoLogo, infoTitle, infoDesc);
            hover.append(hoverLocation, hoverBtn);
            slide.append(info, hover);
            container.appendChild(slide);
        // }
    });
}