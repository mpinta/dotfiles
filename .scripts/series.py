import imdb
import argparse


def print_series_info(series):
    print('--- TV Series info ---')
    print('- Title: ' + series['title'])
    print('- Years filming: ' + series['series years'])
    print('- Rating: ' + str(round(series['rating'], 2)))
    print('- Number or seasons: ' + str(series['number of seasons']))
    print('- Filming countries: ' + ', '.join(series['countries']))
    print('- Genres: '+ ', '.join(series['genres']))
    print('- Plot: ' + series['plot'][0].split(':')[0].lstrip())

def print_episode_info(episode):
    print('--- Episode info ---')
    print('- Title: ' + episode['title'])
    print('- Rating: ' + str(round(episode['rating'], 2)))
    print('- Plot: ' + episode['plot'].lstrip())

def get_series(title):
    i = imdb.IMDb()
    movies = i.search_movie(title)
    series = i.get_movie(movies[0].movieID) 
    i.update(series, 'episodes')
    return series

def get_episode(title, number):
    series = get_series(title)
    season, episode = get_season_and_episode_number(number)
    sorted(series['episodes'].keys())
    return series['episodes'][season][episode]

def get_season_and_episode_number(number):
    season, episode = number[:3][1:], number[3:][1:]
    if season[0] == '0': season = season[1:]
    if episode[0] == '0': episode = episode[1:]
    return int(season), int(episode)

def init_parser():
    parser = argparse.ArgumentParser(description='TV Series info searcher')
    parser.add_argument('--title', '-t', 
                        type=str, 
                        required=True, 
                        help='TV Series title; "<title>"')
    parser.add_argument('--number', '-n', 
                        type=str, 
                        required=False, 
                        help='TV Series season and episode number with leading zero; "s[0]<number>e[0]<number>"')
    return parser

def main():
    parser = init_parser()
    args = parser.parse_args()

    try:    
        if args.number == None:
            print_series_info(get_series(args.title))
        else:
            if len(args.number) != 6:
                raise Exception()
            else:
                print_episode_info(get_episode(args.title, args.number))
    except:
        print('Error occurred when searching..')

if __name__ == '__main__':
    main()

