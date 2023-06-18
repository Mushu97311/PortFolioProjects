select *
from PortfolioProject..CovidDeaths
order by 3, 4

--select *
--from PortfolioProject.dbo.CovidVaccinations
--order by 3, 4

select location, date, total_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1, 2

--looking at toal cases vs total deaths of india

select location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 as deathpercentage
from PortfolioProject..CovidDeaths
where location like 'india'
order by 1, 2

--looking at total cases vs population got covid in india

select location, date, Population, total_cases,(total_cases/population)*100 as totalpopulationcasesperc
from PortfolioProject..coviddeaths
where location like 'india'
order by 1,2

--looking at countries with highest infection rate compared to population

select Location, Population, max(total_cases) as Highestinfectioncount, max(total_cases/population)*100 as percentpopulationinfected
from PortfolioProject..CovidDeaths
--where location like 'india'
group by location, population
order by percentpopulationinfected desc

--showing countries with highest death count per population

select location, max(total_deaths) as totaldeath
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by totaldeath desc

-- break thinks down by CONTINENT

select location, max(total_deaths) as totaldeath
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by totaldeath desc




--- lokking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--- temp table

drop table if exists #percentPopulationVaccinated
create table #percentPopulationVaccinated
(
continent nvarchar (100),
location nvarchar (100),
date datetime,
population numeric,
new_vaccinations numeric,
)
insert into #percentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

select *
from #percentPopulationVaccinated

--- creating view to store data for visualizations

create view percentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select * 
from percentPopulationVaccinated









