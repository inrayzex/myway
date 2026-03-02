<?php

namespace App\Filament\Resources;

use App\Filament\Resources\RecommendationResource\Pages;
use App\Filament\Resources\RecommendationResource\RelationManagers;
use App\Models\Recommendation;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class RecommendationResource extends Resource
{
    protected static ?string $model = Recommendation::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';



public static function form(Form $form): Form
{
    return $form
        ->schema([
            Forms\Components\TextInput::make('title')
                ->required()
                ->maxLength(255)
                ->label('Название'),
            Forms\Components\TextInput::make('author')
                ->maxLength(255)
                ->label('Автор'),
            Forms\Components\FileUpload::make('cover_url')
                ->label('Обложка')
                ->image()
                ->directory('recommendations')
                ->visibility('public')
                ->imagePreviewHeight('150')
                ->maxSize(2048), // 2MB
            Forms\Components\Textarea::make('description')
                ->label('Описание')
                ->maxLength(65535)
                ->columnSpanFull(),
            Forms\Components\Select::make('type')
                ->options([
                    'book' => 'Книга',
                    'video' => 'Видео',
                ])
                ->default('book')
                ->required(),
            Forms\Components\TextInput::make('sort_order')
                ->numeric()
                ->default(0)
                ->label('Порядок сортировки'),
            Forms\Components\Toggle::make('is_active')
                ->label('Активно')
                ->default(true),
        ]);
}




 public static function table(Table $table): Table
{
    return $table
        ->columns([
            Tables\Columns\ImageColumn::make('cover_url')
                ->label('Обложка')
                ->width(50)
                ->height(50),
            Tables\Columns\TextColumn::make('title')
                ->label('Название')
                ->searchable(),
            Tables\Columns\TextColumn::make('author')
                ->label('Автор')
                ->searchable(),
            Tables\Columns\TextColumn::make('type')
                ->label('Тип'),
            Tables\Columns\BooleanColumn::make('is_active')
                ->label('Активно'),
            Tables\Columns\TextColumn::make('sort_order')
                ->label('Сортировка'),
        ])
        ->defaultSort('sort_order');
}



    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListRecommendations::route('/'),
            'create' => Pages\CreateRecommendation::route('/create'),
            'edit' => Pages\EditRecommendation::route('/{record}/edit'),
        ];
    }
}
