<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ChatController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    
    // chat
    Route::get('/chat',[ChatController::class,"index"])->name('chat');
    Route::post('/chat/send/v1',[ChatController::class,"sendV1"])->name('chat.send.v1');
    Route::post('/chat/send/v2',[ChatController::class,"sendV2"])->name('chat.send.v2');
    Route::post('/chat/send/v3',[ChatController::class,"sendV3"])->name('chat.send.v3');
    Route::post('/chat/send/v4',[ChatController::class,"sendV4"])->name('chat.send.v4');
    Route::post('/chat/send/v5',[ChatController::class,"sendV5"])->name('chat.send.v5');

    // profile
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
